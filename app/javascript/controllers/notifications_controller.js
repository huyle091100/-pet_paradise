import Notification from 'stimulus-notification'

export default class extends Notification {
  connect() {
    console.log('Do what you want here.')
    super.connect()
  }
}
