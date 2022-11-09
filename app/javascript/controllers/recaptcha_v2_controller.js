import { Controller } from "stimulus";

export default class extends Controller {
  static values = { siteKey: String };

  initialize() {
    grecaptcha.render("recaptchaV2", { sitekey: this.siteKeyValue });
  }
}
