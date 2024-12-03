import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['refNo'];

  applyKindChanged() {
    const applyKind = this.element.querySelector(
      'input[name="apply[apply_kind]"]:checked'
    ).value;
    this.refNoTarget.style.display = applyKind === '2' ? 'block' : 'none';
  }
}
