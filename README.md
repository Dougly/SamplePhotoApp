# SamplePhotoApp
Small app calling an API to display a list of photos with detail views

Notes:

- 'Allow Arbitrary Loads' property in info.plist allows for app to access insecure http servers.

- JSON is only retrieved once unless the user pull-refreshes the collection view.

- Photo objects are instanced 30 at a time as you scroll through the collection view (as to not create all 5000 when booting up the app)

- Thumbnail image downlowad is triggered by cellFoeItemAtIndexPath and only downloaded once.

- Large image is downloaded when clicking on a cell or swiping to a new cell in the detailVC and only downloaded once.

- Image views display warning icon if image could not be download due to missing connection/error.

- Thumbnail is a placeholder for the large image while it is being downloaded on background thread.

- Tapping detailImageView removes or shows UI elemnts, Swiping up or down closes the detail view, swiping left or right displayes next image.

