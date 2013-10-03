class TransformationNode extends SceneNode {
  PMatrix3D translation;
  PMatrix3D rotation;
  PMatrix3D scaling;
  
  TransformationNode(PMatrix3D _t, PMatrix3D _r, PMatrix3D _s) {
    translation = _t;
    rotation = _r;
    scaling = _s;
  }
  
  void setTranslation(PMatrix3D _t) {
    translation = _t;
  }

  void setRotation(PMatrix3D _r) {
    rotation = _r;
  }
  
  void setScaling(PMatrix3D _s) {
    scaling = _s;
  }
}
