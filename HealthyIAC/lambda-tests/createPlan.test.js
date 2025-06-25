const { handler } = require('./createPlanLambda');

describe('Lambda crear plan', () => {
    it('1. Crea un plan exitosamente con datos válidos', async () => {
        const event = { name: "Plan Saludable", duration: 30, description: "Plan mensual" };
        const result = await handler(event);
        expect(result.statusCode).toBe(201);
        const body = JSON.parse(result.body);
        expect(body.name).toBe("Plan Saludable");
    });

    it('2. Falla si falta el nombre', async () => {
        const event = { duration: 30 };
        const result = await handler(event);
        expect(result.statusCode).toBe(400);
        expect(JSON.parse(result.body).error).toMatch(/obligatorio/);
    });

    it('3. Falla si la duración es negativa', async () => {
        const event = { name: "Plan Negativo", duration: -5 };
        const result = await handler(event);
        expect(result.statusCode).toBe(400);
        expect(JSON.parse(result.body).error).toMatch(/negativa/);
    });

    it('4. Falla si el plan ya existe', async () => {
        const event = { name: "PlanExistente", duration: 10 };
        const result = await handler(event);
        expect(result.statusCode).toBe(409);
        expect(JSON.parse(result.body).error).toMatch(/existe/);
    });

    it('5. Crea un plan solo con campos obligatorios', async () => {
        const event = { name: "Plan Básico" };
        const result = await handler(event);
        expect(result.statusCode).toBe(201);
        const body = JSON.parse(result.body);
        expect(body.name).toBe("Plan Básico");
        expect(body.duration).toBeNull();
        expect(body.description).toBeNull();
    });
});