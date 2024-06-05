import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    this.addEventListeners();
  }

  disconnect() {
    this.removeEventListeners();
  }

  addEventListeners() {
    this.inputTarget.addEventListener('change', this.previewImage.bind(this));
  }

  removeEventListeners() {
    console.log('removing event listeners');
    this.inputTarget.removeEventListener('change', this.previewImage.bind(this));
  }

  previewImage() {
    let file = this.inputTarget.files[0];
    if(file) {
      this.readImageFile(file);
    } else {
      this.previewTarget.src = "";
    }
  }

  readImageFile(file) {
    let reader = new FileReader();
    reader.onloadend = () => {
      this.previewTarget.src = reader.result;
    };
    reader.readAsDataURL(file);
  }
}