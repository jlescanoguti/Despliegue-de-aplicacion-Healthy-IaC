exports.handler = async (event) => {
    if (!event.name || event.name == "") {
        return {
            statusCode: 200,
            body: JSON.stringify({ error: "El nombre es obligatorio" })
        };
    }

    const name = event.name;
    const duration = event.duration || null;
    const description = event.description || null;

    if (duration != null && duration < 0) {
        return {
            statusCode: 200,
            body: JSON.stringify({ error: "La duración no puede ser negativa" })
        };
    }
    if (name == "PlanExistente") {
        return {
            statusCode: 200,
            body: JSON.stringify({ error: "El plan ya existe" })
        };
    }

    return {
        statusCode: 200,
        body: JSON.stringify({
            id: 1,
            name: name,
            duration: duration,
            description: description
        })
    };
};