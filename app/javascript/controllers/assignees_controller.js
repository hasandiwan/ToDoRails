import { Controller } from "@hotwired/stimulus"
import { popupMenu } from "./mixins/popupMenu"

export default class extends Controller {
  static targets = [ "menu", "assignee", "assigneeList" ]

  connect() {
    popupMenu(this)
    this.setLoginUserInfo()
  }

  setLoginUserInfo() {
    const uid = document.getElementById("uid").value
    const assignee = this.assigneeTargets.find(assignee => assignee.dataset.assigneeId == uid)
    this.assigneeListTarget.insertBefore(assignee, this.assigneeListTarget.children[1])
    assignee.querySelector(".uname").textContent = "You"
  }
}
