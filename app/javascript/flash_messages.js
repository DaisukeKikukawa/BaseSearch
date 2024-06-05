document.addEventListener("turbo:load", function() {
  // フラッシュメッセージをすべて取得
  const flashMessages = document.querySelectorAll('.alert-dismissible');

  flashMessages.forEach(flashMessage => {
    // 自動的に閉じる機能
    setTimeout(() => {
      flashMessage.style.display = 'none';
    }, 3000); // 3秒後に非表示

    // クローズボタンのクリックイベント
    const closeButton = flashMessage.querySelector('.close');
    closeButton.addEventListener('click', () => {
      flashMessage.style.display = 'none';
    });
  });
});
