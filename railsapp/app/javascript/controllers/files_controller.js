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
        const blobId = data.id;
        console.log(blobId, fileName, fileUrl);
        // Postコントローラーからのレスポンス(blobデータ)
        this.previewFile(fileName, fileUrl, blobId); // 画像プレビューアクションにblobデータのidを受け渡す
      })
      .catch((error) => {
        console.error(error);
      });
  }

  previewFile(fileName, fileUrl, blobId) {
    // Added blobId parameter
    const fileBox = document.createElement('div');
    fileBox.classList.add('d-flex', 'mb-16');
    fileBox.style.alignItems = 'center';
    fileBox.dataset.filesTarget = 'file_box';
    const linkElement = document.createElement('a');
    linkElement.href = fileUrl;
    linkElement.target = '_blank';
    linkElement.classList.add('d-inline-block', 'text-truncate');
    linkElement.style.maxWidth = '600px';
    linkElement.textContent = fileName;

    const deleteButton = document.createElement('button');
    deleteButton.type = 'button';
    deleteButton.classList.add('btn', 'btn-sm', 'btn-danger', 'ms-auto');
    deleteButton.dataset.action = 'click->files#deleteFile';
    deleteButton.textContent = '削除';

    const hiddenField = document.createElement('input');
    hiddenField.type = 'hidden';
    hiddenField.name = 'apply[files][]';
    hiddenField.value = blobId; // Use blobId here

    fileBox.appendChild(linkElement);
    fileBox.appendChild(deleteButton);
    fileBox.appendChild(hiddenField);

    this.previewTarget.appendChild(fileBox);
  }

  deleteFile(event) {
    console.log('deleteFile');

    const fileBox = event.target.closest("[data-files-target='file_box']");
    console.log(fileBox);
    const blobId = fileBox.querySelector("input[type='hidden']").value;
    const applyId = this.selectTarget.dataset.applyId;

    console.log(blobId);
    console.log(applyId);

    fetch(`/applies/${applyId}/attachments/${blobId}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
          .content,
      },
    }).then((response) => {
      if (response.ok) {
        fileBox.remove();
      }
    });
  }
}
