$(document).on("ready page:load", ->
  $("h1[fittext]").fitText(1.8, { minFontSize: '42px', maxFontSize: '84px' })
  $("h2[fittext]").fitText(1.5, { minFontSize: '32px', maxFontSize: '48px' })
)