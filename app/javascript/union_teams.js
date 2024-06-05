document.addEventListener("turbo:load", function () {
  TeamSelectForms();
});

document.addEventListener("turbo:render", function () {
  TeamSelectForms();
});

function TeamSelectForms() {
  const addButton = $("#addSelectForm");
  const formContainer = $("#selectForms");
  const template = $("#team-select-template");
  const resetButton = $(".union-team-reset-btn");

  addButton.off("click").on("click", function () {
    let newFormGroup = template.clone();
    newFormGroup.removeAttr("style");
    newFormGroup.removeAttr("id");
    newFormGroup.show();
    formContainer.append(newFormGroup);
    attachRemoveEvent(newFormGroup.find(".remove-team"));
    newFormGroup.addClass("d-flex align-items-center");
  });

  resetButton.off("click").on("click", function () {
    // フォームコンテナ内の追加されたフォームを全て削除
    formContainer.find(".form-group").not(":first").remove();
  });

  function attachRemoveEvent(button) {
    button.off("click").on("click", function () {
      $(this).closest(".form-group").remove();
    });
  }

  formContainer.find(".remove-team").each(function () {
    attachRemoveEvent($(this));
  });

  // 初期の削除ボタンにもイベントを設定
  attachRemoveEvent($(".remove-team"));
}
