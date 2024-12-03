import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['oldAssetFields'];

  connect() {
    this.updateOldAssetFields();
  }

  updateOldAssetFields() {
    const checkbox = this.element.querySelector('input[type="checkbox"]');
    if (checkbox) {
      const isChecked = checkbox.checked;
      this.oldAssetFieldsTarget.style.display = isChecked ? 'block' : 'none';
    }
  }
}
