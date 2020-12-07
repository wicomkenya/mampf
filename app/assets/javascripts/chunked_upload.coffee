###
@param url place to upload to
@param extraParams additional query params
@param sessionID which session to use
@param file the file to be uploaded
@param callback to progress
@param callback if succeeded
###
@doUpload = (url, extraParams, sessionID, file, progress, success) ->
  chunkSize = 32000
  aborting = false
  TO = null
  lastChecksum = null
  offset = 0
  lastChunkTime = 4000
  #used for adaptive chunk size recalculation
  xhr = undefined

  uploadNextChunk = ->
    TO = null
    chunkStartTime = (new Date).getTime()
    chunkStart = offset
    chunkEnd = Math.min(offset + chunkSize, file.size) - 1
    currentBlob = (file.slice or file.mozSlice or file.webkitSlice).call(file, chunkStart, chunkEnd + 1)
    if !(currentBlob and currentBlob.size > 0)
      alert 'Chunk size is 0'
      # Sometimes the browser reports an empty chunk when it shouldn't, could retry here
      return
    xhr = new XMLHttpRequest
    if chunkEnd == file.size - 1
      # Add extra URL params on the last chunk
      # Important: URL parameters passing this doesn't work currently, pass parameters via some custom "X-" header instead
      xhr.open 'POST', url + (if url.indexOf('?') > -1 then '&' else '?') + extraParams, true
    else
      xhr.open 'POST', url, true
    # chunking gives usually ~2sec progress you can skip this handler
    xhr.upload.addEventListener 'progress', (e) ->
      if aborting
        return
      progress (chunkStart + e.loaded) / file.size
      return
    xhr.addEventListener 'load', ->
      if aborting
        return
      if xhr.readyState >= 4
        if xhr.status == 200
          progress (chunkEnd + 1) / file.size
          # done
          success xhr.responseText
        else if xhr.status == 201
          offset = chunkEnd + 1
          progress offset / file.size
          adjustChunkSize chunkStartTime
          #the checksum of data uploaded so far
          lastChecksum = xhr.getResponseHeader('X-Checksum')
          TO = setTimeout(uploadNextChunk, 1)
          # attempt to avoid xhrs sticking around longer than needed
        else
          # error, restart chunk
          try
            xhr.abort()
          catch err
          alert 'A server error occurred: ' + xhr.responseText
          # Could retry at this stage depending on xhr.status
      return
    xhr.addEventListener 'error', ->
      if aborting
        return
      # error, restart chunk
      try
        xhr.abort()
      catch err
      alert 'A server error occurred: ' + xhr.responseText
      # Could retry at this stage depending on xhr.status
      return
    xhr.setRequestHeader 'Content-Type', 'application/octet-stream'
    xhr.setRequestHeader 'Content-Disposition', 'attachment; filename="' + encodeURIComponent(file.name) + '"'
    xhr.setRequestHeader 'X-Content-Range', 'bytes ' + chunkStart + '-' + chunkEnd + '/' + file.size
    xhr.setRequestHeader 'X-Session-ID', sessionID
    if lastChecksum
      #client must pass the checksum of all previous chunks
      #this way server will continue checksum calculation
      xhr.setRequestHeader 'X-Last-Checksum', lastChecksum
    xhr.send currentBlob
    return

  adjustChunkSize = (startTime) ->
    end = (new Date).getTime()
    duration = end - startTime
    kbps = Math.round(chunkSize / duration)
    if duration < 2000 and chunkSize < 8 * 1024 * 1024
      #faster, increase chunk size up to 8MB, there will be no more increases over 4MB/s
      # Important: remember about client_max_body_size in nginx config if you alter max chunk size
      chunkSize <<= 1
      console.log 'Increase chunkSize=' + chunkSize + ', kbps=' + kbps
    else if duration > 10000 and chunkSize > 32 * 1024
      #slower, down to min 32KB chunk size, there will be no more decreases below ~3.2KB/s
      chunkSize >>= 1
      console.log 'Increase chunkSize=' + chunkSize + ', kbps=' + kbps
    return

  TO = setTimeout(uploadNextChunk, 1)
  {
    abort: ->
      aborting = true
      if TO != null
        clearTimeout TO
        TO = null
      try
        xhr.abort()
      catch err
      return
    pause: ->
      @abort()
      aborting = false
      return
    resume: ->
      uploadNextChunk()
      return

  }
