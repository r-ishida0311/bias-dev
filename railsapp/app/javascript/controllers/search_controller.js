import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['phoneNumber', 'results'];

  search() {
    console.log('search in');
    const phoneNumber = this.phoneNumberTarget.value;
    fetch(`/search?phone_number=${phoneNumber}`, {
      headers: { Accept: 'text/html' },
    })
      .then((response) => response.text())
      .then((html) => {
        this.resultsTarget.innerHTML = html;
      })
      .catch((error) => {
        console.error('Error fetching search results:', error);
        this.resultsTarget.innerHTML = `<p>Error: ${error.message}</p>`;
      });
  }
}
