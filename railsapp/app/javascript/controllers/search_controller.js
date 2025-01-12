import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['bossNoField', 'results'];

  connect() {
    this.bossNoFieldTarget.addEventListener(
      'input',
      this.handleInput.bind(this)
    );
  }

  handleInput(event) {
    const inputValue = event.target.value;
    if (/^\d{4}$/.test(inputValue)) {
      // Check if it's a 4-digit number
      this.search(event);
    }
  }

  search(event) {
    event.preventDefault();
    const phoneNumber = this.element.querySelector('#boss-no-field').value;

    fetch(`/search?phone_number=${phoneNumber}`, {
      headers: { Accept: 'application/json' },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data && data.length > 0) {
          this.populateBossFields(data[0]);
        } else {
          alert('検索結果がありません。'); // Alert if no results
          return; // Stop further processing
        }
      })
      .catch((error) => {
        console.error('Error fetching search results:', error);
        alert(`エラーが発生しました: ${error.message}`); // Alert on error
      });
  }

  populateBossFields(result) {
    const parentElement = this.element.querySelector(
      '[data-search-target="results"]'
    );
    const bossNameField = parentElement.querySelector('#boss_name');
    const bossEmailField = parentElement.querySelector('#boss_email');
    const bossDepartField = parentElement.querySelector('#boss_depart');

    if (bossNameField) bossNameField.value = result.displayName;
    if (bossEmailField) bossEmailField.value = result.mail;
    if (bossDepartField) bossDepartField.value = result.department;
  }
}
