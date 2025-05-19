# Creating a GitHub Release for v0.1.0

Follow these steps to create a GitHub release for v0.1.0 and attach the .gem file:

## 1. Go to the GitHub Repository

Navigate to your GitHub repository at: https://github.com/Jedt3D/isbn_field

## 2. Create a New Release

1. Click on the "Releases" tab in your repository
2. Click on the "Draft a new release" button
3. In the "Tag version" field, select the existing tag: `v0.1.0`
4. Set the release title to: `ISBN Field v0.1.0`
5. Add a description for the release, for example:

```
Initial release of the ISBN Field gem.

Features:
- ISBN-10 and ISBN-13 validation
- Format checking
- Detailed validation messages
```

## 3. Attach the .gem File

1. Drag and drop the `pkg/isbn_field-0.1.0.gem` file into the "Attach binaries" section
   - Or click on "Attach binaries" and select the file from your computer

## 4. Publish the Release

Click on the "Publish release" button to make the release public.

## 5. Verify the Release

After publishing, verify that:
1. The release appears on the Releases page
2. The .gem file is attached to the release
3. The release is properly tagged with v0.1.0

## Note

This release will make the .gem file available for download directly from GitHub, which is useful for users who want to install the gem manually or for CI/CD pipelines that need to access specific versions of the gem.