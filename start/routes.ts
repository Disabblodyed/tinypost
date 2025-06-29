/*
|--------------------------------------------------------------------------
| Routes file
|--------------------------------------------------------------------------
|
| The routes file is used for defining the HTTP routes.
|
*/

import UsersController from '#controllers/users_controller'
import router from '@adonisjs/core/services/router'

router.get('/', async () => {
  return {
    hello: 'world1',
  }
})

router.get('/health', async ({ response }) => {
  return response.status(200).json({ status: 'healthy' })
})

//Enregistre un nouvel utilisateur
router.post('/auth/register', (ctx) => new UsersController().register(ctx))

