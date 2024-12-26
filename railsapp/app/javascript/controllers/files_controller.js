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
    const fileBox = document.createElement('div');
    fileBox.classList.add('file-box', 'inline-flex', 'mx-1', 'mb-5');
    fileBox.setAttribute('data-controller', 'files');
    fileBox.setAttribute('data-files-target', 'file_box');

    const fileLink = document.createElement('a');
    fileLink.href = fileUrl;
    fileLink.target = '_blank';
    fileLink.textContent = fileName;

    const deleteLink = document.createElement('a');
    deleteLink.classList.add('link', 'cursor-pointer');
    deleteLink.setAttribute('data-action', 'click->files#deleteFile');
    deleteLink.textContent = '削除';

    const hiddenField = document.createElement('input');
    hiddenField.type = 'hidden';
    hiddenField.name = 'apply[files][]';
    hiddenField.value = fileUrl;

    fileBox.appendChild(fileLink);
    fileBox.appendChild(deleteLink);
    fileBox.appendChild(hiddenField);

    this.previewTarget.appendChild(fileBox);
  }
}
