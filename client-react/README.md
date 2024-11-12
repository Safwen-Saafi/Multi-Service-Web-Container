First, we create a vite project with the name client-react

```
npm create vite@latest client-react
```
After that, just paste the content of the client-react folder inside the project we just created.</br>
Then run the same commands as for the node api to install the dependencies.

```
nvm ls
nvm use node 22.11.0
npm install
npm run dev
```
As for the Dockerfiles, there are two variants, one for the development env ( the vite one), and one for the production env ( the nginx one).
