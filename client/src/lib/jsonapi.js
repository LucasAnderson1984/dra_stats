import 'whatwg-fetch';

export function setUrl(url) {
  global.API_URL = url;
}

export function request(resource) {
  return fetch(
    `http://localhost:3001/${resource}.json`,
    {
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/vnd.api+json',
      },
    }
  ).then((response) => {
    if (response.status !== 200) throw new Error(response.statusText);
    return response;
  })
    .then(response => response.json())
}

export function post(resource, data) {
  return fetch(
    `http://localhost:3001/${resource}`,
    {
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/vnd.api+json',
      },
      method: 'POST',
      body: JSON.stringify(data),
    },
  ).then((response) => {
    if (response.status < 200 || response.status > 299) {
      throw new Error(response.statusText);
    }
    return response;
  }).then(response => response.json())
}
