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

    // console.log(applyId); // file_fieldで取得した画像ファイル
    for (const file of files) {
      this.uploadFile(file, applyId); // 選択した画像ファイルのアップロード
    }
    this.selectTarget.value = ''; // 選択ファイルのリセット
  }

  uploadFile(file, applyId) {
    console.log('file', file);
    console.log(applyId);
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
        const fileId = data.id;
        const fileUrl = data.url;

        // Postコントローラーからのレスポンス(blobデータ)
        // this.previewImage(file, data.id); // 画像プレビューアクションにblobデータのidを受け渡す
      })
      .catch((error) => {
        console.error(error);
      });
  }
}
