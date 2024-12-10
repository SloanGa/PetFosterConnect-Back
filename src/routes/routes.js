import { Router } from "express";
import { associationsRoutes } from "./associations.routes.js";
import { animalsRoutes } from "./animals.routes.js";
import { dashboardAssociationRoutes } from "./dashboardAssociation.routes.js";
import { familyRoutes } from "./family.routes.js";
import { departmentsRoutes } from "./departments.routes.js";
import { authRoutes } from "./auth.routes.js";
import { requestsRoutes } from "./requests.routes.js";

const router = Router();

router.use("/associations", associationsRoutes);
router.use("/animals", animalsRoutes);
router.use("/dashboard", dashboardAssociationRoutes);
router.use("/family", familyRoutes);
router.use("/departments", departmentsRoutes);
router.use("/auth", authRoutes);
router.use("/requests", requestsRoutes);

export { router };
