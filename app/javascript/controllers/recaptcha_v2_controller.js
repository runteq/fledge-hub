import { Controller } from "stimulus";

export default class extends Controller {
  static values = { siteKey: String };

  initialize() {
    // eslint-disable-next-line no-undef
    grecaptcha.render("recaptchaV2", { sitekey: this.siteKeyValue });
  }
}
