/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(function () {
  console.log('Hello World from Webpacker');
});

import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

Rails.start();
Turbolinks.start();

import I18n from 'i18n-js';

import 'bootstrap';

import '../src/index.js';
import '../src/administration.coffee';
import '../src/answers.coffee';
import '../src/bootstrap_modal_turbolinks_fix.coffee';
import '../src/chapters.coffee';
import '../src/courses.coffee';
import '../src/file_upload.coffee';
import '../src/items.coffee';
import '../src/katex.coffee';
import '../src/lectures.coffee';
import '../src/lessons.coffee';
import '../src/localization.coffee';
import '../src/main.coffee';
import '../src/media.coffee';
import '../src/notifications.coffee';
import '../src/profile.coffee';
import '../src/questions.coffee';
import '../src/quizzes.coffee';
import '../src/referrals.coffee';
import '../src/registration.coffee';
import '../src/remarks.coffee';
import '../src/sections.coffee'
import '../src/tags.coffee';
import '../src/terms.coffee';
import '../src/tex_preview.coffee';
import '../src/thyme.coffee';
import '../src/thyme_editor.coffee';
import '../src/upload.coffee';
import '../src/users.coffee';
import '../src/vertices.coffee';

import 'bootstrap/dist/css/bootstrap.css';
import '../src/application.scss';
import '../src/chapters.scss';
import '../src/colors.scss';
import '../src/courses.scss';
import '../src/lectures.scss';
import '../src/lessons.scss';
import '../src/main.scss';
import '../src/media.scss';
import '../src/notifications.scss';
import '../src/profile.scss';
import '../src/search.scss';
import '../src/sections.scss';
import '../src/tags.scss';
import '../src/thyme.scss';
import '../src/users.scss';