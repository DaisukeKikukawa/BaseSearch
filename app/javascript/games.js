document.addEventListener("turbo:load", function () {
  scrollToTargetDate();
  handleAwayTeamForm();
  getHeaderHeight();
  changeTeamType();
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

function changeTeamType() {
  var homeTeamableSelectAll = $("#home_teamable_select_all");
  var homeTeamableSelectOnlyTeam = $("#home_teamable_select_only_team");
  var homeTeamableSelectOnlyUnionTeam = $(
    "#home_teamable_select_only_union_team"
  );
  var awayTeamableSelectAll = $("#away_teamable_select_all");
  var awayTeamableSelectOnlyTeam = $("#away_teamable_select_only_team");
  var awayTeamableSelectOnlyUnionTeam = $(
    "#away_teamable_select_only_union_team"
  );

  function hidehomeTeamableSelectAll() {
    $(homeTeamableSelectAll).hide();
    $(homeTeamableSelectAll).prop("disabled", true);
  }
  function hideawayTeamableSelectAll() {
    $(awayTeamableSelectAll).hide();
    $(awayTeamableSelectAll).prop("disabled", true);
  }

  function showhomeTeamableSelectAll() {
    $(homeTeamableSelectAll).show();
    $(homeTeamableSelectAll).prop("disabled", false);
  }

  function showawayTeamableSelectAll() {
    $(awayTeamableSelectAll).show();
    $(awayTeamableSelectAll).prop("disabled", false);
  }

  function hidehomeTeamableSelectOnlyTeam() {
    $(homeTeamableSelectOnlyTeam).hide();
    $(homeTeamableSelectOnlyTeam).prop("disabled", true);
  }

  function hideawayTeamableSelectOnlyTeam() {
    $(awayTeamableSelectOnlyTeam).hide();
    $(awayTeamableSelectOnlyTeam).prop("disabled", true);
  }

  function showhomeTeamableSelectOnlyTeam() {
    $(homeTeamableSelectOnlyTeam).show();
    $(homeTeamableSelectOnlyTeam).prop("disabled", false);
  }

  function showawayTeamableSelectOnlyTeam() {
    $(awayTeamableSelectOnlyTeam).show();
    $(awayTeamableSelectOnlyTeam).prop("disabled", false);
  }

  function hidehomeTeamableSelectOnlyUnionTeam() {
    $(homeTeamableSelectOnlyUnionTeam).hide();
    $(homeTeamableSelectOnlyUnionTeam).prop("disabled", true);
  }

  function hideawayTeamableSelectOnlyUnionTeam() {
    $(awayTeamableSelectOnlyUnionTeam).hide();
    $(awayTeamableSelectOnlyUnionTeam).prop("disabled", true);
  }

  function showhomeTeamableSelectOnlyUnionTeam() {
    $(homeTeamableSelectOnlyUnionTeam).show();
    $(homeTeamableSelectOnlyUnionTeam).prop("disabled", false);
  }

  function showawayTeamableSelectOnlyUnionTeam() {
    $(awayTeamableSelectOnlyUnionTeam).show();
    $(awayTeamableSelectOnlyUnionTeam).prop("disabled", false);
  }

  hidehomeTeamableSelectOnlyTeam();
  hidehomeTeamableSelectOnlyUnionTeam();
  hideawayTeamableSelectOnlyTeam();
  hideawayTeamableSelectOnlyUnionTeam();

  $("#home_teamable_type_select").on("change", function () {
    var selectedHomeValue = $(this).val();

    if (selectedHomeValue == "Team") {
      showhomeTeamableSelectOnlyTeam();
      hidehomeTeamableSelectOnlyUnionTeam();
      hidehomeTeamableSelectAll();
    } else if (selectedHomeValue == "UnionTeam") {
      showhomeTeamableSelectOnlyUnionTeam();
      hidehomeTeamableSelectOnlyTeam();
      hidehomeTeamableSelectAll();
    } else if (selectedHomeValue == "") {
      showhomeTeamableSelectAll();
      hidehomeTeamableSelectOnlyUnionTeam();
      hidehomeTeamableSelectOnlyTeam();
    }
  });

  $("#away_teamable_type_select").on("change", function () {
    var selectedAwayValue = $(this).val();
    console.log(selectedAwayValue);

    if (selectedAwayValue == "Team") {
      showawayTeamableSelectOnlyTeam();
      hideawayTeamableSelectOnlyUnionTeam();
      hideawayTeamableSelectAll();
    } else if (selectedAwayValue == "UnionTeam") {
      showawayTeamableSelectOnlyUnionTeam();
      hideawayTeamableSelectOnlyTeam();
      hideawayTeamableSelectAll();
    } else if (selectedAwayValue == "") {
      showawayTeamableSelectAll();
      hideawayTeamableSelectOnlyUnionTeam();
      hideawayTeamableSelectOnlyTeam();
    }
  });
}
