import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['department', 'roles', 'rolesSelect'];

  connect() {
    console.log('connect');
    this.updateRoles();
  }

  updateRoles() {
    const departmentId = this.departmentTarget.value;
    const selectedRoleId = parseInt(this.data.get('selectedId')); // Get the role_id from data attribute

    fetch(`/departments/${departmentId}/roles`)
      .then((response) => response.json())
      .then((data) => {
        this.rolesSelectTarget.innerHTML = ''; // Clear existing options
        this.rolesSelectTarget.insertAdjacentHTML(
          'beforeend',
          '<option value=""></option>'
        ); //Add empty option
        data.forEach((role) => {
          const option = document.createElement('option');
          option.value = role.id;
          option.text = role.role;
          if (role.id === selectedRoleId) {
            option.selected = true; // Set the option as selected if it matches the role_id from data attribute
          }
          this.rolesSelectTarget.appendChild(option);
        });
      });
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

  departmentValueChanged() {
    this.updateRoles();
  }
}
