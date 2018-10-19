/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

$(document).ready(function(){
  $(".new_vote").submit((event) => {
    event.preventDefault();
    let active_element = document.activeElement;
    let form = $(active_element).parent();
    let data = form.serializeArray();

    let request = $.ajax({
      method: "POST",
      data: data,
      url: '/api/v1/votes.json'
    });

    request.done((response) => {
      let net_votes_div = $(`.net_votes_${response.review_id}`);
      $(net_votes_div).text(response.updated_net_votes);
    });

    request.always((response) => {
      $(active_element).removeAttr("disabled");

      let vote_new = $(active_element).prev().val();
      let other_down = $(`#${response.review_id}.down`);
      let other_up = $(`#${response.review_id}.up`);

      if (vote_new === "true") {
        other_element = other_down;
      } else {
        other_element = other_up;
      }


      if (response.previous_vote === null) {
        $(active_element).addClass("warning");
      } else if (String(response.previous_vote) === vote_new) {
        $(active_element).removeClass("warning");
      } else {
        $(active_element).addClass("warning");
        $(other_element).removeClass("warning");
      }
    });
  });
});

// $('#fixed_callout_container').scroll(function() {
//     $('#fixed_callout').css('top', $(this).scrollTop());
// });
