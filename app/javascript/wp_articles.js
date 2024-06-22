document.addEventListener("turbo:load", function () {
  adjustPaginationPosition();
});

document.addEventListener("turbo:render", function () {
});

function adjustPaginationPosition() {
  var footer = $("#footer");
  var pagination = document.querySelector(".pagy-footer");

  if (footer && pagination) {
    var footerHeight = footer.outerHeight();
    pagination.style.marginBottom = footerHeight + 10 + "px";
    console.log(footerHeight)
  }
}
