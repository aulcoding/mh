import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application



// import { Application } from "@hotwired/stimulus";
// import HelloController from "./hello_controller";

// const application = Application.start();
// application.register("hello", HelloController);
export { application }