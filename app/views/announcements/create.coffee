# present errors if they exists, otherwise reload page
<% if @errors.present? %>
$('#announcement-error').empty().append('<%= @errors %>').show()
$('#announcement_details').addClass('is-invalid')
<% else %>
location.reload(true)
<% end %>