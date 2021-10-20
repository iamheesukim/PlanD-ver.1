import React from "react";
import { CKEditor } from "@ckeditor/ckeditor5-react";
import ClassicEditor from "@ckeditor/ckeditor5-build-classic";
import styled from "styled-components";

const CKEditorWrapper = styled.div`
  .ck-content {
    height: 400px;
  }
`;

const CustomCKEditor = () => {
  return (
    <CKEditorWrapper>
      <CKEditor
        editor={ClassicEditor}
        data="<p>추천 내용을 입력해 주세요</p>"
      ></CKEditor>
    </CKEditorWrapper>
  );
};

export default CustomCKEditor;