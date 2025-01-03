import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="selectdep"
export default class extends Controller {
  static targets = ['department'];

  yearEqChange(event) {
    const year = event.target.value;
    const departmentSelect = this.departmentTarget;
    console.log('connected');
    if (year === '') {
      departmentSelect.innerHTML =
        '<option value="">年度を選択してください</option>';
    } else {
      fetch(`/applies/:apply_id/departments_by_year?year=${year}`)
        .then((response) => response.json())
        .then((data) => {
          console.log('Received data:', data);
          departmentSelect.innerHTML = ''; //既存のオプションをクリア

          // 空白のオプションを追加
          const blankOption = document.createElement('option');
          blankOption.value = '';
          blankOption.text = '';
          departmentSelect.appendChild(blankOption);

          // データの各要素に対してオプションを作成
          data.forEach((department) => {
            const option = document.createElement('option');
            option.value = department;
            option.text = department;
            departmentSelect.appendChild(option);
          });
        })
        .catch((error) => {
          console.error('Error fetching departments:', error);
        });
    }
  }
}
