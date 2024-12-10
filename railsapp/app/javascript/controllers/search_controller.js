import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['phoneNumber', 'results'];

  search(event) {
    // Add event parameter
    event.preventDefault(); // Prevent default form submission

    const phoneNumber = this.element.querySelector('#boss-no-field').value;

    fetch(`/search?phone_number=${phoneNumber}`, {
      headers: { Accept: 'application/json' },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data && data.length > 0) {
          this.populateBossFields(data[0]);
        } else {
          this.resultsTarget.innerHTML = '<p>No results found</p>';
        }
      })
      .catch((error) => {
        console.error('Error fetching search results:', error);
        this.resultsTarget.innerHTML = `<p>Error: ${error.message}</p>`;
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

    console.log(bossNameField.value);
    console.log(bossEmailField.value);
    console.log(bossDepartField.value);

    console.log(this.resultsTarget.innerHTML);
  }
}
