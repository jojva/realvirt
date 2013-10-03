class ShapeNode extends SceneNode {
  int id;
  SceneNode geometry;
  SceneNode material;
  
  ShapeNode() {
    geometry = null;
    material = null;
  }
  
  void setGeometry(GeometryNode _g) {
    geometry = _g;
  }
  
  void setMaterial(MaterialNode _m) {
    material = _m;
  }
}
