optimApp <-
function() {
  appDir<- system.file("optimStrat", "myapp", package = "optimStrat")
  if (appDir == "") {stop("Could not find directory. Try re-installing `optimStrat`.", call. = FALSE)}
  shiny::runApp(appDir,display.mode="normal")
}
