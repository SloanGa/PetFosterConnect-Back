import { Association } from "../models/associations.js";
import { validateAndSanitize } from "../middlewares/validateAndSanitize.js";
import { ValidationError } from "../middlewares/customErrors.js";

const associationsController = {
    index: async (req, res) => {
        /*
       fetch and return  res.json() all associations
        */
        const associations = await Association.findAll({
            include: "department",
        });
        res.json(associations);
    },
    findOne: async (req, res, next) => {
        /*
    fetch with req.params and return res.json() one association
     */
        const { id } = req.params;
        const association = await Association.findByPk(id, {
            include: "department",
        });
        if (!association) {
            return next();
        }
        res.json(association);
    },

    filter: async (req, res, next) => {
        /*
        fetch, filter with req.query and return res.json() all corresponding associations
         */

        const buildWhereClause = (query) => {
            // Validation des données
            const { error, value } = validateAndSanitize.associationSearchFilter.validate(query);
            if (error) {
                return next(new ValidationError());
            }

            const associationWhere = {};
            const animalWhere = {};

            if (query.department_id) associationWhere.department_id = query.department_id;
            if (query.species) animalWhere.species = query.species;

            return { associationWhere, animalWhere };
        };

        const { associationWhere, animalWhere } = buildWhereClause(req.query);

        const associations = await Association.findAll({
            where: associationWhere,
            include: [
                "department",
                {
                    association: "animals",
                    where: animalWhere,
                },
            ],
        });
        res.json(associations);
    },
};

export { associationsController };
