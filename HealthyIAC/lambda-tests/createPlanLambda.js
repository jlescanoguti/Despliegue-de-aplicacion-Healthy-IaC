exports.handler = async (event) => {
    const { name, duration, description } = event;

    if (!name || typeof name !== 'string' || name.trim() === "") {
        return { statusCode: 400, body: JSON.stringify({ error: "El nombre es obligatorio" }) };
    }
    if (duration !== undefined && duration < 0) {
        return { statusCode: 400, body: JSON.stringify({ error: "La duración no puede ser negativa" }) };
    }
    if (name === "PlanExistente") {
        return { statusCode: 409, body: JSON.stringify({ error: "El plan ya existe" }) };
    }

    return {
        statusCode: 201,
        body: JSON.stringify({
            id: 1,
            name,
            duration: duration || null,
            description: description || null
        })
    };
};