'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "fcd3a7a4a4de801c5df214c7623b221b",
"version.json": "e08ffd5feeac7cb11747b4d03a4352b2",
"index.html": "cd64396e52c3a7c49f0bd604d00bb311",
"/": "cd64396e52c3a7c49f0bd604d00bb311",
"main.dart.js": "62e9ec3e62896d70c32884c04bf07d66",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "f94cedcfa8c0b730572a18e4e2cb9c32",
"icons/Icon-192.png": "c19e0d2d4277def438c834395399eb8e",
"icons/Icon-maskable-192.png": "c19e0d2d4277def438c834395399eb8e",
"icons/Icon-maskable-512.png": "051a13ea5e4f34ea7bb0274b74cbfc5f",
"icons/Icon-512.png": "051a13ea5e4f34ea7bb0274b74cbfc5f",
"manifest.json": "c64239d253584487f620a87ce462d3c7",
"assets/AssetManifest.json": "084574245bcdd2f60c9930c3e65bb6e7",
"assets/NOTICES": "eb58d3400067cd23207d166345f14bb5",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "315e4476654f19e83ed2a8b378f7e7c7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flame_splash_screen/assets/layer1.png": "31625c711892b1d250fe3bb58ad32850",
"assets/packages/flame_splash_screen/assets/layer3.png": "24a8fdc53b85d6d749cc2857c708de49",
"assets/packages/flame_splash_screen/assets/layer2.png": "51efb74c8ec5a2fd21f622392678f607",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "9b1f8e1c54527e4c4541fea4a72565ac",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/assets/images/Splash/background.jpg": "0df679897f9e7e49b3016b23875e8867",
"assets/assets/images/Game/Kylin/background.jpg": "18af780934a5e7417bc3308cc0351197",
"assets/assets/images/background.jpg": "0df679897f9e7e49b3016b23875e8867",
"assets/assets/images/Common/musicOnButton.png": "5c3dacdeaa31c217da0bfa3d514e41a8",
"assets/assets/images/Common/musicOffButton.png": "10a4508d2a3598cf7e53dfb2db2ef953",
"assets/assets/images/Common/startButton.png": "d19e58abb79ddb5e22b707a691bfb97c",
"assets/assets/images/Common/closeButton.png": "c3a3a752139b8f4a54167dfa4a4b0614",
"assets/assets/images/Map/background.jpg": "63538b47d03611f86ceb7d7bb71d3b98",
"assets/assets/images/Map/Building/school.png": "3ab9fa7e2ecf0106e84e775c57b1351a",
"assets/assets/images/Map/Building/house.png": "3617a7690fc418b24b60da7ac7abff9e",
"assets/assets/audio/Splash/bgm.mp3": "f0e2dac0eacc73e87c6f8b1ffd84b0f8",
"assets/assets/audio/Game/Kylin/bgm.mp3": "f0e2dac0eacc73e87c6f8b1ffd84b0f8",
"assets/assets/audio/bgm.mp3": "f0e2dac0eacc73e87c6f8b1ffd84b0f8",
"assets/assets/lottie/loading.json": "679f26ad02588d2ca392077ea8f37d35",
"assets/assets/lottie/Kylin/running.json": "16a4f9cd4282ec2b159e596854f2922a",
"assets/assets/lottie/Kylin/jumping.json": "f863d636a349c2b99c9442c1f23e61ae",
"assets/assets/lottie/Kylin/movingBackground.json": "8336fd119ef20802ea06da94a938e94a",
"assets/assets/lottie/Common/loading.json": "679f26ad02588d2ca392077ea8f37d35",
"assets/assets/lottie/Common/gameOver.json": "b17d9c845b639991430241d135e08d1c",
"assets/assets/lottie/Common/gameLoading.json": "163f1f6f25fb59c961843185d53971ae",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
