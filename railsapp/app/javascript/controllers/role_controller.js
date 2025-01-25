import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['department', 'roles', 'rolesSelect'];

  connect() {
    console.log('connect');
    this.updateRoles();
  }

  departmentValueChanged() {
    this.updateRoles();
  }

  updateHiddenRoleId(rolesData) {
    if (this.rolesSelectTarget.value) {
      const selectedRole = rolesData.find(
        (role) => role.id === parseInt(this.rolesSelectTarget.value, 10)
      );
      const hiddenField = document.querySelector(
        'input[name="apply[role_id]"]'
      );
      hiddenField.value = selectedRole ? selectedRole.id : '';
    }
  }

  updateRoles() {
    const departmentId = this.departmentTarget.value;
    const selectedRoleId = parseInt(this.data.get('selectedId')); // Get the role_id from data attribute

    fetch(`/departments/${departmentId}/roles`)
      .then((response) => response.json())
      .then((data) => {
        this.rolesSelectTarget.innerHTML = ''; // Clear existing options
        console.log(data);
        if (data.length === 0) {
          this.rolesSelectTarget.insertAdjacentHTML(
            'beforeend',
            '<option value="" disabled selected>選択した部署に対応する担当がありません</option>'
          );
        } else {
          this.rolesSelectTarget.insertAdjacentHTML(
            'beforeend',
            '<option value="">担当を選択してください</option>'
          );
          data.forEach((role) => {
            const option = document.createElement('option');
            option.value = role.id;
            option.text = role.role;
            if (role.id === selectedRoleId) {
              option.selected = true; // Set the option as selected if it matches the role_id from data attribute
            }
            this.rolesSelectTarget.appendChild(option);
          });
        }
      });
  }
}
