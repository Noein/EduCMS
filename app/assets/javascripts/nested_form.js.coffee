# Copyright (C) 2011-2012 Vladislav Mileshkin
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

jQuery ($) ->
$("form a.add_nested_fields").live "click", ->
assoc = $(this).attr("data-association")
content = $("#" + assoc + "_fields_blueprint").html()
context = ($(this).closest(".fields").find("input:first").attr("name") or "").replace(new RegExp("[[a-z]+]$"), "")
if context
  parent_names = context.match(/[a-z_]+_attributes/g) or []
  parent_ids = context.match(/(new_)?[0-9]+/g) or []
  i = 0

  while i < parent_names.length
    if parent_ids[i]
      content = content.replace(new RegExp("(_" + parent_names[i] + ")_.+?_", "g"), "$1_" + parent_ids[i] + "_")
      content = content.replace(new RegExp("(\\[" + parent_names[i] + "\\])\\[.+?\\]", "g"), "$1[" + parent_ids[i] + "]")
      i++
      regexp = new RegExp("new_" + assoc, "g")
      new_id = new Date().getTime()
      content = content.replace(regexp, "new_" + new_id)
      field = $(content).insertBefore(this)
      $(this).closest("form").trigger
      type: "nested:fieldAdded"
      field: field

      false

      $("form a.remove_nested_fields").live "click", ->
      hidden_field = $(this).prev("input[type=hidden]")[0]
      hidden_field.value = "1"  if hidden_field
      $(this).closest(".fields").hide()
      $(this).closest("form").trigger "nested:fieldRemoved"
      false
