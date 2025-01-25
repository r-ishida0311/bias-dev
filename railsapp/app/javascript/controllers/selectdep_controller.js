import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="selectdep"
export default class extends Controller {
  static targets = ['department', 'role'];

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

  depEqChange(event) {
    const dep = event.target.value;
    const roleSelect = this.roleTarget;
    console.log(dep);

    if (dep === '') {
      roleSelect.innerHTML = '<option value="">部署を選択してください</option>';
    } else {
      fetch(`/applies/${this.data.get('apply-id')}/role_by_dep?dep=${dep}`) // Include apply_id
        .then((response) => response.json())
        .then((data) => {
          console.log('Received data:', data);
          roleSelect.innerHTML = ''; // Clear existing options

          if (data.length === 0) {
            // Handle the case where no roles are found
            const noRolesOption = document.createElement('option');
            noRolesOption.value = '';
            noRolesOption.text = '担当はありません';
            noRolesOption.disabled = true; // Prevent selection
            noRolesOption.selected = true; // Make it the default option
            roleSelect.appendChild(noRolesOption);
          } else {
            // Add a blank option as a placeholder if roles exist
            const blankOption = document.createElement('option');
            blankOption.value = '';
            blankOption.text = '担当を選択してください';
            roleSelect.appendChild(blankOption);

            data.forEach((role) => {
              const option = document.createElement('option');
              option.value = role;
              option.text = role;
              roleSelect.appendChild(option);
            });
          }
        })
        .catch((error) => {
          console.error('Error fetching roles:', error);
        });
    }
  }
}
