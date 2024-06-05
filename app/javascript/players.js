/* App */
document.addEventListener("turbo:load", function() {
  positionFilter();
});

function positionFilter() {
  var lists = $(".list li");

  $(document).on("change", ".serchBox select", function () {
    $(".list li").show(); // Show all list items initially

    for (var i = 0; i < $(".serchBox select").length; i++) {
      // 絞り込みの項目を取得
      var item = $(".serchBox select").eq(i).attr("name");
      // 絞り込みの対象を取得
      var target = $(".serchBox select").eq(i).val();

      if (target != "") {
        for (var j = 0; j < lists.length; j++) {
          // 絞り込み対象でない場合は非表示
          if (
            !lists
              .eq(j)
              .find("." + item)
              .find("span." + target).length &&
            item === "defensive-position"
          ) {
            lists.eq(j).hide();
          }
        }
      }
    }
  });
}

/* CMS */
document.addEventListener("turbo:load", function() {
  SubPositionForms();
});

document.addEventListener("turbo:render", function() {
  SubPositionForms();
});

function SubPositionForms() {
  const addButton = $("#addSubPosition");
  const deleteButton = $("#deleteSubPosition");
  const formContainer = $("#subPositionForms");
  const formGroup = formContainer.find(".form-group");
  let selectCounter = 0;

  addButton.off("click").on("click", function() {
    let cloneSelectForm = formGroup.find("select").first().clone(true);
    selectCounter++;
    cloneSelectForm.attr("id", "sub_position_" + selectCounter);
    formGroup.append(cloneSelectForm);
  });

  deleteButton.off("click").on("click", function() {
    const SelectformCount = formGroup.find("select").length;

    if (SelectformCount > 1) {
      formGroup.find("select").last().remove();
    }
  });
}

