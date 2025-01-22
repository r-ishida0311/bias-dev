import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['department', 'roles', 'rolesSelect'];

  connect() {
    console.log('connect');
    this.updateRoles();
  }

  updateRoles() {
    const departmentId = this.departmentTarget.value;
    console.log(departmentId);
    if (departmentId) {
      fetch(`/departments/${departmentId}/roles`)
        .then((response) => response.json())
        .then((data) => {
          this.rolesSelectTarget.innerHTML = ''; // Clear existing options
          this.rolesSelectTarget.insertAdjacentHTML(
            'beforeend',
            '<option value="">Select Role</option>'
          ); //Add empty option
          data.forEach((role) => {
            const option = document.createElement('option');
            option.value = role.id;
            option.text = role.role;
            this.rolesSelectTarget.appendChild(option);
          });
          //Added this to set the initial hidden role_id based on the data from the server
          this.updateHiddenRoleId(data);
        });
    } else {
      this.rolesSelectTarget.innerHTML =
        '<option value="">Select Role</option>';
    }
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
