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
    const files = this.selectTargets[0].files; // file_fieldで取得した画像ファイル
    for (const file of files) {
      console.log(file.name);
      this.uploadImage(file); // 選択した画像ファイルのアップロード
    }
    this.selectTarget.value = ''; // 選択ファイルのリセット
  }
}
