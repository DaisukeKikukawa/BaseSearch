document.addEventListener("turbo:load", function () {
  navigateToTopAfterSplash();
});

function navigateToTopAfterSplash() {
  const splashWrap = $(".splash-wrap");
  const splashTarget = $("#splash");

  setTimeout(function () {
    splashTarget.addClass("fade-out");
  }, 1000);

  setTimeout(function () {
    splashWrap.remove();
  }, 2000);
}