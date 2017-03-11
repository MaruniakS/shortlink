copyToClipboard = (elem) ->
# create hidden text element, if it doesn't already exist
  targetId = '_hiddenCopyText_'
  isInput = elem.tagName == 'INPUT' or elem.tagName == 'TEXTAREA'
  origSelectionStart = undefined
  origSelectionEnd = undefined
  if isInput
# can just use the original source element for the selection and copy
    target = elem
    origSelectionStart = elem.selectionStart
    origSelectionEnd = elem.selectionEnd
  else
# must use a temporary form element for the selection and copy
    target = document.getElementById(targetId)
    if !target
      target = document.createElement('textarea')
      target.style.position = 'absolute'
      target.style.left = '-9999px'
      target.style.top = '0'
      target.id = targetId
      document.body.appendChild target
    target.textContent = elem.textContent
  # select the content
  currentFocus = document.activeElement
  target.focus()
  target.setSelectionRange 0, target.value.length
  # copy the selection
  succeed = undefined
  try
    succeed = document.execCommand('copy')
  catch e
    succeed = false
  # restore original focus
  if currentFocus and typeof currentFocus.focus == 'function'
    currentFocus.focus()
  if isInput
# restore prior selection
    elem.setSelectionRange origSelectionStart, origSelectionEnd
  else
# clear temporary content
    target.textContent = ''
  succeed

toggleCopy = () ->
  if $('#copy-url:hidden').length == 0
    $('#copy-url').hide()
    $('#submit-url').show()

$(document).on 'click', '#copy-url', (e) ->
  copyToClipboard document.getElementById('link-input')
  return
$(document).on 'paste', '#url-form #link-input', (e) ->
  setTimeout (->
    $('#submit-url').click()
    return
  ), 100
  return
$(document).on 'keyup', '#link-input', (e) ->
  toggleCopy()
  return
$(document).on 'keyup', '#custom-link', (e) ->
  toggleCopy()
  return
