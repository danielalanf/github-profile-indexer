import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    text: String,
    type: String,
  };

  connect() {
    const Toast = Swal.mixin({
      toast: true,
      position: "top-end",
      showConfirmButton: false,
      showCancelButton: true,
      cancelButtonText: "OK",
      timer: 6000,
      timerProgressBar: true,
      didOpen: (toast) => {
        toast.addEventListener("mouseenter", () => Swal.stopTimer);
        toast.addEventListener("mouseleave", () => Swal.resumeTimer);
      },
    });

    Toast.fire({
      icon: this.typeValue,
      title: this.textValue,
    });
  }
}
