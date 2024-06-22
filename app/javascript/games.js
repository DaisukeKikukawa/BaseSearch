document.addEventListener("turbo:load", function () {
  scrollToTargetDate();
  handleAwayTeamForm();
  getHeaderHeight();
});

document.addEventListener("turbo:render", function() {
  handleAwayTeamForm();
});

function scrollToTargetDate() {
  let dateParam = new URLSearchParams(window.location.search).get('date');
  let targetDate = dateParam ? new Date(dateParam) : new Date();
  let targetId = targetDate.toISOString().slice(0,10).replace(/-/g, '');
  let targetElement = $('#' + targetId);

  if (targetElement.length) {
    let headerHeight = $('#header').outerHeight() + $('#game-filter-wrapper').outerHeight();
    $('html, body').animate({
      scrollTop: targetElement.offset().top - headerHeight
    }, 1000);
  }
}

function handleAwayTeamForm() {
  const $selectElement = $('.team-select');
  const $textFieldElement = $('.team-text-field');
  const $hiddenField = $('#hidden-away-team-id');


  if ($textFieldElement.val() !== "") {
    $selectElement.prop('disabled', true);
  } else if ($selectElement.val() !== "") {
    $textFieldElement.prop('readonly', true);
  }

  $selectElement.on('change', function () {
    if ($(this).val() !== "") {
      $textFieldElement.prop('readonly', true);
    } else {
      $textFieldElement.prop('readonly', false);
    }
  });

  $textFieldElement.on('input', function () {
    if ($(this).val() !== "") {
      $selectElement.prop('disabled', true);
    } else {
      $selectElement.prop('disabled', false);
    }
  });
}

function getHeaderHeight() {
  var header = $('#header');
  var gameFilterHeader = $('#game-filter-wrapper');

  if (header.length && gameFilterHeader.length) {
      var headerHeight = header.outerHeight();
      gameFilterHeader.css('top', headerHeight + 'px');
  }
}
