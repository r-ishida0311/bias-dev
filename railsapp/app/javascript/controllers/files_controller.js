import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="files"
export default class extends Controller {
  /* ①静的プロパティを定義（data-{controller}-target で指定したターゲット名） */
  static targets = ['select', 'preview', 'file_box'];

  connect() {
    // console.log('Files controller connected');
  }
  selectFiles() {
    const applyId = this.selectTarget.dataset.applyId;
    const files = this.selectTargets[0].files;

    for (const file of files) {
      this.uploadFile(file, applyId); // 選択した画像ファイルのアップロード
    }
    this.selectTarget.value = ''; // 選択ファイルのリセット
  }

  uploadFile(file, applyId) {
    const csrfToken = document.getElementsByName('csrf-token')[0].content; // CSRFトークンを取得
    const formData = new FormData();
    formData.append('file', file);
    formData.append('apply_id', applyId);
    const options = {
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken,
      },
      body: formData,
    }; /* fetchで画像ファイルをPostコントローラー(upload_imageアクション)に送信 */
    fetch('/applies/upload_file', options)
      .then((response) => response.json())
      .then((data) => {
        console.log('Upload successful:', data);
        const fileName = data.file_name;
        const fileUrl = data.url;
        console.log(fileName, fileUrl);
        // Postコントローラーからのレスポンス(blobデータ)
        this.previewFile(fileName, fileUrl); // 画像プレビューアクションにblobデータのidを受け渡す
      })
      .catch((error) => {
        console.error(error);
      });
  }

  previewFile(fileName, fileUrl) {
    const reader = new FileReader();
    console.log(fileName, fileUrl);
    reader.onload = (event) => {
      // this.previewTarget.appendChild();
    };
  }
}
