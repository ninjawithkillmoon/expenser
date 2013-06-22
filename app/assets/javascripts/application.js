// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery-ui-1.10.3.custom
//= require jquery.ui.touch-punch
//= require chosen.jquery
//= require fuelux/fuelux.spinner
//= require moment
//= require bootstrap-datepicker
//= require bootstrap-timepicker
//= require daterangepicker
//= require bootstrap-colorpicker
//= require jquery.knob
//= require jquery.autosize
//= require jquery.inputlimiter.1.3.1
//= require jquery.maskedinput
//= require ace-elements
//= require ace
//= require jquery.validate
//= require_self

jQuery(function() {
  var activeTab = jQuery("[href=" + location.hash + "]");
  activeTab && activeTab.tab("show");

  // don't initialize anything in a tab - inactive tabs have issues with these
  jQuery(".date-picker").not(".tab-pane .date-picker").datepicker();
  jQuery(".chzn-select").not(".tab-pane .chzn-select").chosen();
  jQuery(".chzn-select-deselect").not(".tab-pane .chzn-select-deselect").chosen({allow_single_deselect:true});

  // initialize the active tab separately
  activateTabElements();

  // make sure that other tabs' contents are initialized when we switch to them
  jQuery('a[data-toggle="tab"]').on('shown', function (e) {
    activateTabElements();
  })
})

/**
 * Initializes the datepickers, chosens, etc that are in the currently active tab
 */
function activateTabElements() {
  jQuery(".active .date-picker").datepicker();

  jQuery(".active .chzn-select").chosen();
  jQuery(".active .chzn-select-deselect").chosen({allow_single_deselect:true});
}

