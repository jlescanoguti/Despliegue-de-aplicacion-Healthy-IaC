const { handler } = require("./index.js");

describe('Lambda handler', () => {
    it('crea un plan exitosamente', async () => {
        // Arrange
        const event = { name: 'Plan Saludable', duration: 30, description: "Plan mensual" };
        const expected = JSON.stringify({
            id: 1,
            name: 'Plan Saludable',
            duration: 30,
            description: "Plan mensual"
        });

        // Act
        const result = await handler(event);
        expect(result.body).toBe(expected);
    });

    it('falla si falta el nombre', async () => {
        const event = { duration: 30 };
        const expected = JSON.stringify({ error: "El nombre es obligatorio" });

        const result = await handler(event);
        expect(result.body).toBe(expected);
    });

    it('falla si la duración es negativa', async () => {
        const event = { name: "Plan Negativo", duration: -5 };
        const expected = JSON.stringify({ error: "La duración no puede ser negativa" });

        const result = await handler(event);
        expect(result.body).toBe(expected);
    });

    it('falla si el plan ya existe', async () => {
        const event = { name: "PlanExistente", duration: 10 };
        const expected = JSON.stringify({ error: "El plan ya existe" });

        const result = await handler(event);
        expect(result.body).toBe(expected);
    });

    it('crea un plan solo con nombre', async () => {
        const event = { name: "Plan Básico" };
        const expected = JSON.stringify({
            id: 1,
            name: "Plan Básico",
            duration: null,
            description: null
        });

        const result = await handler(event);
        expect(result.body).toBe(expected);
    });
});