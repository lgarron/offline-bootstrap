# HTML5 Offline Caching Bootstrap

*Make your client-side web apps load offline with ease.*

I've had several recent projects that are fully client-side web apps ([twisty.js](http://www.cubing.net/twisty.js/) and [Mark 2](http://www.cubing.net/mark2/)). Thus, it should be possible to run them offline. Fortunately, [HTML5 Offline Caching](http://www.cubing.net/twisty.js/) allows a user to cache the files needed for loading a particular URL while offline. Unfortunately, there are a lot of subtleties to making this work right.

This is my attempt to simplify the process by providing a bootstrap -- a collection of files that can get you started because they already work. They should be easy to adapt to a simple project, and provide a starting point for more complicated ones.

Right now, the code is based on the twisty.js/Mark 2 code. It is not fully robust, but I've found that it works well in practice already.

## How to use it

- Place the `inc/` directory in your project, including `inc/.htaccess`, `inc/cache.manifest`, `inc/offline_storage_example.png`, and `inc/offline.html`. Alternatively, you can place the files in another folder (even `./`), but you'll have to update the references yourself, which is a bit tricky.
- Update `inc/cache.manifest` to include your project files.

## Details

- Take the Javascript cache update code from `index.html` and place it in any files you want to have auto-reload on a cache update.
- Link to `inc/offline.html` from any page that needs a link for starting the offline caching.
- In `inc/offline.html`, customize the page title, `h1` title, and the link in step 3 with the name of your project.

## How it works

The most important part of the caching process is a file called the manifest, which is at `inc/cache.manifest` in this project. It needs to be served with the MIME type `text/cache-manifest`, which is handled by `inc/.htaccess`.

Normally, it is sufficient to include some code on a page to make it load offline. This has a few drawbacks, including:

- It forces users to cache the page offline, which may not be desired (and can lead to issues with stale content if you don't know what you're doing).
- Firefox will always ask users if they want allow your site to store data on your computer, which can easily annoy them or make them suspicious.
- It is harder to provide a general way to inform users about what is going on.

Therefore, I like to use a separate file, `inc/offline.html`. If a user visits that page, it loads the manifest, and caches several files, *including the original page* and any scripts or images it needs. Now, the original page can load offline for the user. In addition, if the manifest changes, then a cache update will be triggered any time they visit any of the files in the manifest while they're online.	

This means that *the contents of the cache.manifest file should be changed every time the files are changed* on the server (else the browser will assume the cache is up to date). I've included a sample `deploy.sh` script that inserts the current date and time into the manifest so that a conventional `rsync` deployment will always force browsers to refresh the cache next (online) visit.

## HTML5 Offline Caching References

- [The Spec](http://www.cubing.net/twisty.js/)
- [html5rocks](http://www.html5rocks.com/en/tutorials/offline/whats-offline/)
- [Dive into HTML5](http://diveintohtml5.org/offline.html)