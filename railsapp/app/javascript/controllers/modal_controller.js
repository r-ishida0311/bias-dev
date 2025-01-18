import { Controller } from '@hotwired/stimulus';
// BootstrapのModalをimport
import { Modal } from 'bootstrap';

export default class extends Controller {
  // `connect()`はStimulusのライフサイクルコールバックの1つ
  // コントローラーがHTML要素にアタッチされた時（=HTML要素が画面に表示された時）に実行される
  connect() {
    console.log('connect');
    this.modal = new Modal(this.element);

    // モーダルを表示する
    this.modal.show();
  }

  // アクション定義
  // 保存成功時にモーダルを閉じる
  close(event) {
    console.log('close');
    if (event.detail.success) {
      console.log('success');
      this.modal.hide();
    }
  }
}
