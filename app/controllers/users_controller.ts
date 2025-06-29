import type { HttpContext } from '@adonisjs/core/http'
import User from '#models/user'

export default class UsersController { 
    /**
     * Gère l'enregistrement des utilisateurs.
     * @param {HttpContext} ctx - Le contexte HTTP.
     * @returns {Promise<void>} - Une promesse qui se résout lorsque l'enregistrement est terminé.
     */
    public async register({ request, response }: HttpContext) {
        const { email, password, fullName} = request.all()

        try {
            const user = await User.create({ email, password, fullName }) // Adonis hash automatiquement le mot de passe si configuré

            return response.created({
                message: 'User registered successfully',
                user: {
                    id: user.id,
                    email: user.email,
                }
            })
        } catch (error) {
            return response.badRequest({ message: 'Registration failed', error: error.message })
        }
    }
}