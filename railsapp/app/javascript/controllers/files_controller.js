import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="files"
export default class extends Controller {
  /* ①静的プロパティを定義（data-{controller}-target で指定したターゲット名） */
  static targets = ['select', 'preview', 'file_box'];

  connect() {
    console.log('Files controller connected');
  }
  selectFiles() {
    console.log('file selected');
  }
}
